import jwt from 'jsonwebtoken';
import { Request, Response, NextFunction } from "express";

function isAuthenticated(req: Request, res: Response, next: NextFunction) {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).send('Un-Authorized');
  }

  try {
    const token = authorization.split(' ')[1];
    const payload = jwt.verify(token, process.env.JWT_TOKEN ?? "");
    req.user = payload;
  } catch (err: any) {
    if (err.name === 'TokenExpiredError') {
      return res.status(401).send(err.name);
    }
    return res.status(401).send('Un-Authorized');
  }

  return next();
}

export {
  isAuthenticated
};
