import crypto from 'crypto';

export const generateHash = (data: string): string => {
  const passwordHash = crypto.createHash("sha1");
  return passwordHash.update(data).digest("hex");
};
