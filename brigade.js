const KOLLA_VERSION = "3.0.2"
const CONTAINER = "quay.io/charter-os/kolla-brigade:" + KOLLA_VERSION

const { events, Job } = require("brigadier")

events.on("exec", (e, p) => {

  //debug info
  console.log("==> Project " + p.name + " clones the repo at " + p.repo.cloneURL)
  console.log("==> Event " + e.type + " caused by " + e.provider)


  // create job with name and container image to use
  var kb_job = new Job("kb-job", CONTAINER)

  // allow docker socket
  kb_job.docker.enabled = true

  //set up tasks
  kb_job.tasks = [] //init empty tasks

  kb_job.tasks.push("source /src/start.sh") // add first task - build kolla container

  kb_job.tasks.push("source /src/push.sh") // add next task - push image to registry

  //kb_job.tasks.push("./src/cleanup.sh") // add final task - clean up image

  //set up ENV
  // TODO: SECRETS
  kb_job.env = {
    "KOLLA_BASE": "ubuntu",
    "KOLLA_TYPE": "source",
    "KOLLA_TAG": "3.0.2-kb",
    "KOLLA_PROJECT": "keystone",
    "KOLLA_NAMESPACE": "charter-os",
    "KOLLA_VERSION": KOLLA_VERSION,
    "DOCKER_USER": p.secrets.docker_user,
    "DOCKER_PASS": p.secrets.docker_pass,
    "DOCKER_REGISTRY": "quay.io",
    "REPO_BASE": "https://github.com/openstack",
    "PROJECT_REFERENCE": "stable/ocata",
    "PROJECT_GIT_COMMIT": "e1a94f39edb6cf777c71c7a511476b1e60436ab9",
    "RELEASE": "stable-ocata"
  }


  console.log("==> Set up tasks, env, Job: ")
  console.log(kb_job)

  console.log("==> Running Job")

  // run Job, get Promise and print results
  kb_job.run().then( result => {
    console.log("==> Job Results")
    console.log(result.toString())
    console.log("==> Done")
  })

  

})