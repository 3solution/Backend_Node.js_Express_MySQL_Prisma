import { IUser } from '@entities/User';
const emailRegexp = new RegExp(
  /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
);

type TErrorMessage = {
  is_valid: boolean;
  error_msgs: string[];
};

const validateRegisterParams = (params: IUser) => {
  const msg: TErrorMessage = {
    is_valid: false,
    error_msgs: [],
  };

  if (!params) {
    msg.error_msgs.push('No parameter asigned.');
    return msg;
  }

  if (typeof params.name !== 'string' || params.name === '') msg.error_msgs.push('Invalid name');
  if (typeof params.surname !== 'string' || params.surname === '') msg.error_msgs.push('Invalid surname');
  if (typeof params.email !== 'string' || params.email === '' || !emailRegexp.test(params.email)) msg.error_msgs.push('Invalid email');
  if (typeof params.phone !== 'string' || params.phone === '') msg.error_msgs.push('Invalid phone number');
  if (typeof params.currency !== 'string' || params.currency === '') msg.error_msgs.push('Invalid phone number');
  if (typeof params.password !== 'string' || params.password === '') msg.error_msgs.push('Invalid password');

  if (msg.error_msgs.length === 0) {
    msg.is_valid = true;
  }
  return msg;
};

const validateLoginParams = (params: { email?: string, password?: string}) => {
  const msg: TErrorMessage = {
    is_valid: false,
    error_msgs: [],
  };

  if (!params) {
    msg.error_msgs.push('No parameter asigned.');
    return msg;
  }

  if (typeof params.email !== 'string' || params.email === '' || !emailRegexp.test(params.email)) msg.error_msgs.push('Invalid email');
  if (typeof params.password !== 'string' || params.password === '') msg.error_msgs.push('Invalid password');

  if (msg.error_msgs.length === 0) {
    msg.is_valid = true;
  }
  return msg;
};

export {
  validateRegisterParams,
  validateLoginParams,
};