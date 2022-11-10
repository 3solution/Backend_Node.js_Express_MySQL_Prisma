import db from "src/utils/db";

function getMembership(id: any) {
  return db.users.findUnique({
    where: { id },
  });
}

export { getMembership };
