import db from "src/utils/db";

function saveSceneData(uid: any, data: any) {
  return db.app_scene_info.upsert({
    where: { uid },
    update: {
      uid: uid,
      ...data,
    },
    create: {
      uid: uid,
      ...data,
    },
  });
}

function importSceneData(uid: any) {
  return db.app_scene_info.findUnique({
    where: { uid },
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

export { saveSceneData, importSceneData };
