module WorkerHelper

  def create_worker(worker_id, name, active)
    worker = Worker.where(worker_id: worker_id).first_or_initialize
    worker.name   = name
    worker.active = active

    worker.save
  end
end
