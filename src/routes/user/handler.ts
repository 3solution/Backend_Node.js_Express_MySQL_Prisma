import StatusCodes from "http-status-codes";
import { Request, Response } from "express";
import { findUserAll } from "src/services/user";

const { OK } = StatusCodes;

export async function getAllUserData(req: Request, res: Response) {
  console.log(req.user);
  
  const data = await findUserAll({});
  return res.status(OK).json(data);
}
