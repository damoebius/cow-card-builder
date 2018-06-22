package node;

import js.node.events.EventEmitter;
import js.Promise;

@:jsRequire("puppeteer")
extern class Puppeteer {
    public static function launch():Promise<Browser>;
}

interface Browser {
    public function newPage():Promise<Page>;
}

interface Page extends IEventEmitter {
    public function goto(url:String):Promise<Response>;
}

interface Response {

}
