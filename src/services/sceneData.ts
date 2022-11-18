import db from "src/utils/db";

function saveSceneData(uid: any, data: any) {
  // return db.app_scene_info.upsert({
  //   where: { uid, name: data.name },
  //   update: {
  //     uid: uid,
  //     ...data,
  //   },
  //   create: {
  //     uid: uid,
  //     ...data,
  //   },
  // });
}

function findSceneData(uid: any, name: any) {
  return db.app_scene_info.findFirst({
    where: { uid, name },
  });
}

function createSceneData(uid: any, data: any) {
  return db.app_scene_info.create({
    data: {
      uid: uid,
      ...data,
    },
  });
}

function updateSceneData(id: any, uid: any, data: any) {
  return db.app_scene_info.update({
    where: {
      id,
    },
    data: {
      uid: uid,
      ...data,
    },
  });
}

// >await Promise.all(
// >    roles.map(async (role) => prisma.role.upsert({
// >      where: {
// >        id: role.id
// >      },
// >      update: {},
// >      create: role,
// >    }))
// >  );

function getIdeasNames(uid: any) {
  return db.app_scene_info.findMany({
    where: { uid },
  });
}

export {
  findSceneData,
  createSceneData,
  updateSceneData,
  saveSceneData,
  getIdeasNames,
};
