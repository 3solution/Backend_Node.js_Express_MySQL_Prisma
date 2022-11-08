import { IUser } from '@entities/User';
import db from "src/utils/db";
import { generateHash } from 'src/utils/hash';

function findUser(cond: any) {
  console.log('cond: ', cond);
  return db.user.findUnique({
    where: cond,
  });
}

function findUserAll(cond: any) {
  return db.user.findMany({
    where: cond,
  });
}

function createUser(user: IUser) {
  return db.user.create({
    data: user,
  });
}

export {
  findUser,
  createUser,
  findUserAll
};