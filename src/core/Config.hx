package core;

import haxe.Json;
import js.node.Fs;

class Config {

    private static var _instance:Config;

    public var cards:String;

    private function new() {
    }

    public static function getInstance():Config {
        if (_instance == null) {
            var configFile = Fs.readFileSync(js.Node.__dirname + "/config.json", "");
            _instance = Json.parse(configFile);
        }
        return _instance;
    }
}

