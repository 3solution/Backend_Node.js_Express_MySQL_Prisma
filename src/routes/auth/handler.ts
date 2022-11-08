import { validateLoginParams, validateRegisterParams } from "src/utils/validation";
import { Request, Response, NextFunction } from "express";
import { createUser, findUser } from "src/services/user";
import { generateToken } from "src/utils/jwt";
import { generateHash } from "src/utils/hash";

const registerUser = async (req: Request, res: Response) => {
  try {
    const validation = validateRegisterParams(req.body);
    if (!validation.is_valid) {
      return res.status(403).send(validation.error_msgs.toString());
    }

    const {
      phone, password, email, surname, name, currency
    } = req.body;

    const existingUser = await findUser({ email });
    console.log('existingUser: ', existingUser);

    if (existingUser) {
      return res.status(400).send('Email is already in use.');
    }

    const token = generateToken(email);

    const user = await createUser({
      phone, password: generateHash(password), email, name, surname, currency, token
    });
    console.log('user: ', user);

    return res.status(200).json({
      email,
      token,
    });
  } catch (err: any) {
    console.log('err: ', err.message);
    return res.status(500).send(err.message);
  }
};

const loginUser = async (req: Request, res: Response) => {
  try {
    const validation = validateLoginParams(req.body);
    if (!validation.is_valid) {
      return res.status(403).send(validation.error_msgs.toString());
    }

    const { password, email } = req.body;

    const existingUser = await findUser({ email });
    console.log('existingUser: ', existingUser);

    if (!existingUser) {
      return res.status(403).send('User does not exist. Please sign up first.');
    }

    const validPassword = generateHash(password) === existingUser.password;
    
    if (!validPassword) {
      return res.status(403).send('Password is wrong.');
    }

    const token = generateToken(email);
    return res.status(200).json({
      email,
      token,
    });
  } catch (err: any) {
    console.log('err: ', err.message);
    return res.status(500).send(err.message);
  }
};

export {
  registerUser,
  loginUser,
};