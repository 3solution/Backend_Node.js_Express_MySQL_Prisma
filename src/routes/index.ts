import { Router } from "express";
import userRouter from "./user";
import sceneDataRouter from "./sceneData";
const baseRouter = Router();

baseRouter.use("/user", userRouter);
baseRouter.use("/scene-data", sceneDataRouter);

export default baseRouter;
