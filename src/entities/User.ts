export interface IUser {
  id?: number;
  name: string;
  surname: string;
  crypto?: string[];
  currency: string;
  email: string;
  phone: string;
  address1?: string;
  address2?: string;
  city?: string;
  country?: string;
  photoURL?: string;
  roles?: Array<string>;
  devices?: Array<string>;
  isVerified?: boolean;
  token?: string;
  verificationToken?: string;
  password: string;
  passwordResetToken?: string;
  ipAddress?: string;
  deviceToken?: string;
  confirmationCode?: string;
  terms_accepted_on?: number;
  lastLogin?: {
    date: string;
    time: string;
    ipAddress: string;
  };
  debug?: number;
  last_sync_time?: {
    [key in LastSyncTimeKey]: number;
  };
  isApproved?: boolean;
  notification?: {
    displayed: boolean;
    acknowledged: boolean;
    message: string;
  };
}

export type LastSyncTimeKey =
  | "account_balance"
  | "chart_data"
  | "chart_data_hourly"
  | "monthly_performance_data";

export interface IUserActivity {
  user_id: string;
  activity: string;
  sub_activity?: string;
  additional_info?: Record<string, unknown>;
  status?: string;
  timestamp?: number;
}
