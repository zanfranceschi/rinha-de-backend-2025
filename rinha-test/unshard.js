const util = require("util");
const $ = util.promisify(require("child_process").exec);
const fs = require("fs");
const path = require("path");

const TOTAL_CHUNKS = 10;
const SOURCE_DIR = path.join(__dirname, "..", "participantes");

const chunkNumberArg = process.argv[2];

if (chunkNumberArg === undefined) {
  console.error("Error: You must provide a chunk number as an argument.");
  console.error("Usage: node chunk.js <chunk_number>");
  process.exit(1);
}

const CHUNK_NUMBER = parseInt(chunkNumberArg, 10);

if (isNaN(CHUNK_NUMBER) || CHUNK_NUMBER < 0 || CHUNK_NUMBER >= TOTAL_CHUNKS) {
  console.error(
    `Error: Chunk number must be an integer between 0 and ${TOTAL_CHUNKS - 1}.`,
  );
  process.exit(1);
}

(async () => {
  try {
    const allEntries = fs.readdirSync(SOURCE_DIR);
    const allFolders = allEntries.filter((entry) => {
      const entryPath = path.join(SOURCE_DIR, entry);
      return fs.statSync(entryPath).isDirectory();
    });

    for (const folder of allFolders) {
      await $(`mv ../participantes/${folder} ../participantes-onhold`);
    }

    await $("rm -rf ../participantes");
    await $("mv ../participantes-onhold ../participantes");
  } catch (error) {
    if (error.code === "ENOENT") {
      console.error(`Error: Source directory '${SOURCE_DIR}' not found.`);
    } else {
      console.error("An unexpected error occurred:", error);
    }
    process.exit(1);
  }
})().finally(() => {
  process.exit(0);
});
