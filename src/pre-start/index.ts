/**
 * Pre-start is where we want to place things that must run BEFORE the express server is started.
 * This is useful for environment variables, command-line arguments, and cron-jobs.
 */

import path from "path";
import dotenv from "dotenv";
import Debug from "debug";
const debug = Debug("BTCS.API.pre-start");

(() => {
  if (process.env.HEROKU == "1") {
    debug(`Environment Variables are handled differently`);
  } else {
    // Set the env file
    const envFilePath = path.join(
      __dirname,
      `/../../env/${process.env.NODE_ENV || "development"}.env`
    );
    debug(
      `Initializing Environment Variables. Loading env file from ${envFilePath}`
    );
    const result = dotenv.config({
      path: envFilePath,
    });
    if (result.error) {
      debug(`Environment file cannot be located`);
      throw result.error;
    }
  }
})();
