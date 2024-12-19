import { describe, expect, it } from "bun:test";
import { runTerraformApply, runTerraformInit, executeScriptInContainer } from "../modules/test";

describe("docker-nvm-aws", async () => {
  await runTerraformInit(import.meta.dir);

  it("Clone hvim source code successfully", async () => {
   const state = await runTerraformApply(import.meta.dir, {
        agent_id: "foo",
    });
    const output = await executeScriptInContainer(state, "alpine/git");
    expect(output.exitCode).toBe(0);
    expect(output.stdout).toEqual(expect.arrayContaining([
      "Cloning https://github.com/hungknow/nvim-config.git to ~/.config/nvim..."
    ]));
  })
})
