import { describe, expect, it } from "bun:test";
import { runTerraformApply, runTerraformInit, executeScriptInContainer } from "../test";

describe("awscli", async () => {
  await runTerraformInit(import.meta.dir);

  it("Install AWS-CLI on alpine successfully", async () => {
   const state = await runTerraformApply(import.meta.dir, {
        agent_id: "foo",
    });
    const output = await executeScriptInContainer(state, "alpine");
    expect(output.stderr).toEqual([""]);
    expect(output.exitCode).toBe(0);
    expect(output.stdout).toEqual(expect.arrayContaining([
      "Installed AWS-CLI v2"
    ]));
  })

  it("Install AWS-CLI on Ubuntu successfully", async () => {
   const state = await runTerraformApply(import.meta.dir, {
        agent_id: "foo",
    });
    const output = await executeScriptInContainer(state, "ubuntu");
    // expect(output.stderr).toEqual([""]);
    expect(output.exitCode).toBe(0);
    expect(output.stdout).toEqual(expect.arrayContaining([
      "Installed AWS-CLI v2"
    ]));
  })

})
