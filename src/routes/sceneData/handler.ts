import StatusCodes from "http-status-codes";
import e, { Request, Response } from "express";
import { saveSceneData, importSceneData } from "src/services/sceneData";

const { OK } = StatusCodes;

export async function saveData(req: Request, res: Response) {
  try {
    const { uid } = req.params;
    const data = req.body;
    await saveSceneData(parseInt(uid), data);
    res.json("OK");
  } catch (error: any) {
    console.log("error: ", error.message);
    return res.status(500).send(error.message);
  }
}

export async function importData(req: Request, res: Response) {
  try {
    const { uid } = req.params;
    const data = await importSceneData(parseInt(uid));
    return res.status(200).json({
      ...data,
    });
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
