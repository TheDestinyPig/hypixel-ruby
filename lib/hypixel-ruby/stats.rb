module Hypixel

    class Stats

        attr_reader :packages, :coins, :json, :fields

        # Constructs a Stats instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Stats.new (json['stats'] ||= {})
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @packages = {}
            @coins = {}
            @json = {}
            @fields = {}

            json.keys.each do | key |
                gameType = GameType.from_db_name key

                @packages[gameType] = json[key]['packages'] ||= []
                @coins[gameType] = json[key]['coins'] ||= 0
                @json[gameType] = json[key]
                @fields[gameType] = {}

                json[key].each do | key, value |
                    @fields[gameType][key] = value
                end
            end
        end
    end
end
