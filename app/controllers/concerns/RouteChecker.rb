module RouteChecker
  INITIAL_SEGMENT_REGEX = %r{^/([^/(:]+)}

  def self.initial_path_segments
    @initial_path_segments ||= Set.new.tap do |s|
      Rails.application.routes.routes.each do |x|
        path = x.path.spec.to_s
        (match = INITIAL_SEGMENT_REGEX.match(path)) && s.add(match[1])
      end
    end
  end

  def self.path?(route)
    return false if route.blank?

    route = route.split('/').compact_blank
    initial_path_segments.include?(route.first)
  end
end
