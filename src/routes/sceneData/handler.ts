import StatusCodes from "http-status-codes";
import e, { Request, Response } from "express";
import { getMembership } from "src/services/user";

const { OK } = StatusCodes;

export async function getMembershipState(req: Request, res: Response) {
  try {
    const { uid } = req.params;

    const userInfo = await getMembership(parseInt(uid));

    let membershipId = 0;
    const today = new Date();

    if (userInfo?.membership_id && userInfo?.membership_id !== 0) {
      if (userInfo?.mem_expire && userInfo?.mem_expire >= today) {
        membershipId = userInfo?.membership_id;
      } else {
        membershipId = 0;
      }
    } else {
      membershipId = 0;
    }

    return res.status(200).json({
      membershipId,
    });
  } catch (err: any) {
    console.log("err: ", err.message);
    return res.status(500).send(err.message);
  }
}
