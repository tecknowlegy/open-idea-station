module Acorn
  class InitRedis
    Start ||= Redis::Namespace.new("acorn", { redis: Redis.new })
  end
end
