import { Router } from "express";
import jwt from "express-jwt";
import authRouter from "./auth";
import userRouter from "./user";

const baseRouter = Router();

baseRouter.use("/user", userRouter);
baseRouter.use("/auth", authRouter);

export default baseRouter;
