const { events, Job } = require("brigadier")

events.on("exec", (e, p) => {

  //debug info
  console.log("==> Project " + p.name + " clones the repo at " + p.repo.cloneURL)
  console.log("==> Event " + e.type + " caused by " + e.provider)


  // create job
  var kb_job = new Job("kb_job", "quay.io/charter-os/kolla-brigade:0.1.0")

  // allow docker socket
  kb_job.docker.enabled = true

  //set up tasks
  kb_job.tasks = [] //init empty tasks

  kb_job.tasks.push("./src/start.sh") // add first task - prepare env

  kb_job.tasks.push("./src/push.sh") // add next task - push image to registry

  kb_job.tasks.push("./src/cleanup.sh") // add final task - clean up image

  //set up ENV

  kb_job.env = {
    "KOLLA_BASE": "ubuntu",
    "KOLLA_TYPE":"source",
    "KOLLA_TAG":"3.0.2-kb",
    "KOLLA_PROJECT":"keystone",
    "KOLLA_NAMESPACE":"charter-os",
    "KOLLA_VERSION":"3.0.2",
    "DOCKER_USER":"user",
    "DOCKER_PASS":"pass",
    "DOCKER_REGISTRY":"quay.io"
  }



  console.log("==> Set up tasks, env, Job: " + kb_job)

  console.log("==> Running Job")

  // run Job, get Promise and print results
  kb_job.run().then( result => {
    console.log("==> Job Results")
    console.log(result.toString())
  })

  console.log("==> Done")

})