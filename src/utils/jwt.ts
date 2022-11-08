import jwt from 'jsonwebtoken';

const generateToken = (email: string) => jwt.sign({ email }, process.env.JWT_TOKEN ?? "", {
  expiresIn: '8h',
})

export {
  generateToken,
};
