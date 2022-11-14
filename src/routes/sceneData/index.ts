import { Router } from "express";
import { getMembershipState } from "./handler";

const userRouter = Router();
// userRouter.get("/membership/:uid", getMembershipState);

export default userRouter;
