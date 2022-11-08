import { Router } from "express";
import { isAuthenticated } from "src/utils/middleware";
import { getAllUserData } from "./handler";

const userRouter = Router();
userRouter.get("/all", isAuthenticated, getAllUserData);

export default userRouter;
