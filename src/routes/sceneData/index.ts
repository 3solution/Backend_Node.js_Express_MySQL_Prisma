import { Router } from "express";
import { saveData, importData } from "./handler";

const sceneDataRouter = Router();
sceneDataRouter.post("/save/:uid", saveData);
sceneDataRouter.get("/import/:uid", importData);

export default sceneDataRouter;
