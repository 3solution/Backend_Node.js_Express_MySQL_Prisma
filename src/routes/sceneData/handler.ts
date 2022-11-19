import StatusCodes from "http-status-codes";
import e, { Request, Response } from "express";
import {
  findSceneData,
  createSceneData,
  updateSceneData,
  saveSceneData,
  getIdeasNames,
} from "src/services/sceneData";

const { OK } = StatusCodes;

export async function saveData(req: Request, res: Response) {
  try {
    const { uid } = req.params;
    const data = req.body;
    const findData = await findSceneData(parseInt(uid), data.name);
    console.log("findData: ", findData);
    if (findData) {
      await updateSceneData(findData.id, parseInt(uid), data);
      return res.json("update success");
    } else {
      await createSceneData(parseInt(uid), data);
      return res.json("create success");
    }
    // res.json("OK");
  } catch (error: any) {
    console.log("error: ", error.message);
    return res.status(500).send(error.message);
  }
}

export async function importData(req: Request, res: Response) {
  try {
    const { uid } = req.params;
    const { name } = req.body;
    const data = await findSceneData(parseInt(uid), name);
    console.log("data: ", data);
    res.json({
      ...data,
    });
  } catch (error: any) {
    console.log("error: ", error.message);
    return res.status(500).send(error.message);
  }
}

export async function getNames(req: Request, res: Response) {
  try {
    const { uid } = req.params;
    const data = await getIdeasNames(parseInt(uid));
    return res.json(data);
  } catch (error: any) {
    console.log("error: ", error.message);
    return res.status(500).send(error.message);
  }
}
// export async function getMembershipState(req: Request, res: Response) {
//   try {
//     const { uid } = req.params;

//     const userInfo = await getMembership(parseInt(uid));

//     let membershipId = 0;
//     const today = new Date();

//     if (userInfo?.membership_id && userInfo?.membership_id !== 0) {
//       if (userInfo?.mem_expire && userInfo?.mem_expire >= today) {
//         membershipId = userInfo?.membership_id;
//       } else {
//         membershipId = 0;
//       }
//     } else {
//       membershipId = 0;
//     }

//     return res.status(200).json({
//       membershipId,
//     });
//   } catch (err: any) {
//     console.log("err: ", err.message);
//     return res.status(500).send(err.message);
//   }
// }
