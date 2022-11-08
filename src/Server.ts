import cookieParser from "cookie-parser";
import morgan from "morgan";
import helmet from "helmet";
import cors from "cors";
import requestIp from "request-ip";

import express, { NextFunction, Request, Response } from "express";
import StatusCodes from "http-status-codes";
import "express-async-errors";
import * as useragent from "express-useragent";

import BaseRouter from "./routes";
import logger from "jet-logger";
const app = express();
const { INTERNAL_SERVER_ERROR } = StatusCodes;
import jwt from "express-jwt";

app.use(express.json({ limit: "8mb" }));
app.use(cors());
app.use(express.urlencoded({ extended: true, limit: "8mb" }));
app.use(cookieParser());

// eslint-disable-next-line @typescript-eslint/no-unsafe-call
app.use(requestIp.mw());

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}

if (process.env.NODE_ENV === "production") {
  app.use(morgan("combined"));
  app.use(helmet());
}

app.use(express.json());
app.use(useragent.express());

// app.use(jwt({ secret: "jwtSecret", algorithms: ["HS256"] }));

app.use("/api", BaseRouter);

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  logger.err(err.message, true);
  return res.status(INTERNAL_SERVER_ERROR).json({
    error: "Something went wrong",
  });
});

export default app;
