# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Creating an Array of new objects using a block, where the block is executed for each object:
# User.create([{ :first_name => 'Jamie' }, { :first_name => 'Jeremy' }]) do |u|
#   u.is_admin = false
# end
User.create([
  { name: "Chupa-cabras",     email: "psw1@psw.com", password: "pswpsw" },
  { name: "Chupa-xups",       email: "psw2@psw.com", password: "pswpsw" },
  { name: "Chupa-ovelhas",    email: "psw3@psw.com", password: "pswpsw" },
  { name: "Chupa-lagartos",   email: "psw4@psw.com", password: "pswpsw" },
  { name: "Chupa-lambisgoia", email: "psw5@psw.com", password: "pswpsw" }])

Tag.create([
  { name: "Vai, Messi",     color: "#111111" },
  { name: "vagaba",         color: "#222222" },
  { name: "lolipop",        color: "#222222" },
  { name: "lolmatic",       color: "#222222" },
  { name: "cavalo de fogo", color: "#222222" }])

def build_task task, i
  users = User.all.limit(i + 1).to_a
  random_user = -> { users[rand(i + 1)] }
  tags  = Tag.all.limit(i + 1).to_a
  comments = []
  (i+1).times do
    comments << FirstPageComment.new(commenter: random_user.call,
                                     body: "Gorpo rooaar #{i}")
  end

  task.requester = random_user.call
  task.workers  << random_user.call
  task.tags     << tags[i]
  task.first_page_comments = comments
  task
end

def build_tasks task_name, project = nil
  tasks = []
  open_fields   = [{ title: "Soltar pipa",    description: "Soltar sim. Tem que passar cerol\nCortar geral"},
                   { title: "Jogar bola",     description: "JKh sjhsj sjkh"},
                   { title: "Malhar",         description: "M hjash asdkhdkah"},
                   { title: "correr",         description: "Co aosd aso ddsa"},
                   { title: "nadar",          description: "N ksjdlsadsa"}]
  closed_fields = [{ title: "Voar",           description: "Vç salkj"},
                   { title: "Teletransporte", description: "T djalkjds"},
                   { title: "Optical Blast",  description: "O jkadhhsad"},
                   { title: "Regenerar",      description: "R lkdsjkas"},
                   { title: "queimar cosmos", description: "Qu ,kjsalda"}]
  
  5.times do |i|
    if task_name == "open"
      tasks << build_task(OpenTask.new(title: open_fields[i][:title],
                                       description: open_fields[i][:description],
                                       active: true), i)
    elsif task_name == "closed"
      tasks << build_task(OpenTask.new(title: closed_fields[i][:title],
                                       description: closed_fields[i][:description],
                                       active: true), i)
    end
  end

  closed_tasks = []
  if task_name == "closed" # Closed tasks have the same id and attributes of open
    tasks.each do |task|
      closed_tasks << ClosedTask.where(id: task.id).first_or_create(attributes: task.attributes)
      task.active = false
    end
    project.open_tasks += tasks
    project.save!
    tasks = closed_tasks
  end

  tasks
end

project_a = Project.create
project_a.update_attributes(open_tasks: build_tasks("open"),
                            closed_tasks: build_tasks("closed", project_a))
project_a_sprint = ProjectSprint.new(open_task_ids: [ project_a.open_tasks[0].id, project_a.open_tasks[1].id ], closed_tasks: [ project_a.closed_tasks[0], project_a.closed_tasks[1] ]) 
project_a.sprints = [ project_a_sprint ]
project_a.allocateds = [ User.all.first ]
project_a.save!

project_task_a = ProjectTask.new
project_task_a.project       = project_a
project_task_a.open_task_ids = [ project_a.open_tasks[0].id,   project_a.open_tasks[3].id ]
project_task_a.closed_tasks  = [ project_a.closed_tasks[0],    project_a.closed_tasks[3] ]
company_x_sprint = CompanySprint.new(project_tasks: [ project_task_a ],
                                     end_date:   Date.today)
cia = Company.new(sprints: [ company_x_sprint ],
                  projects: [ project_a ])
cia.save!