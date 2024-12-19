import { describe, expect, it } from "bun:test";
import { runTerraformApply, runTerraformInit } from "../test";

describe("hvim", async () => {
  await runTerraformInit(import.meta.dir);

  it("run OK", async () => {
   const state = await runTerraformApply(import.meta.dir, {
        agent_id: "foo",
    });
  })
})
