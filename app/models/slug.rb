# This is an attempt to use custom names instead of integer ids as part of
# our URL `uid`
class Slug
  class << self
    def [](slug)
      redis.hget(hash, slug)
    end

    # Every post id will have an associated set whose members are
    # the slugs which map to that post id.
    # That is, whenever we map a slug to a post id, we will also add
    # that slug to the set of slugs associated with that post id.
    # Moreover, as it is possible to update a slug to point to a different
    # post id, we will first need to remove that slug from the set of
    # slugs for the old post id.
    def []=(slug, id)
      old = self[slug]
      redis.srem(set(old), slug) if old
      redis.hset(hash, slug, id)
      redis.sadd(set(id), slug)
    end

    def destroy(id)
      redis.smembers(set(id)).each { |slug| redis.hdel(hash, slug) }
      redis.del(set(id))
    end

    private

    def redis
      Acorn::InitRedis::Start
    end

    def hash
      "idea_ids"
    end

    def set(id)
      "idea_slugs_#{id}"
    end
  end
end
