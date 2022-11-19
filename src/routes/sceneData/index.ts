import { Router } from "express";
import { saveData, importData, getNames } from "./handler";

const sceneDataRouter = Router();
sceneDataRouter.post("/save/:uid", saveData);
sceneDataRouter.get("/import/:uid", importData);
sceneDataRouter.get("/names/:uid", getNames);

export default sceneDataRouter;
