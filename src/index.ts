import "./pre-start"; // Must be the first import
import app from "@server";
import logger from "jet-logger";
import requestIp from "request-ip";
import cors from "cors";

// Start the server
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(requestIp.mw({ attributeName: "clientIp" }));
app.listen(PORT, () => {
  logger.info("Express server started on port: " + PORT);
});

export default app;
