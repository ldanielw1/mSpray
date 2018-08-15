module WorkerHelper

  def create_worker(worker_id, name, status)
    worker = Worker.where(worker_id: worker_id).first_or_initialize
    worker.name   = name
    worker.status = status

    worker.save
  end
end
