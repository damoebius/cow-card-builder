package node;

import js.node.events.EventEmitter;
import js.Promise;

@:jsRequire("puppeteer")
extern class Puppeteer {
    public static function launch(?options:LaunchOptions):Promise<Browser>;
}

interface Browser {
    public function newPage():Promise<Page>;
}

interface Page extends IEventEmitter {
    public function goto(url:String):Promise<Response>;
    public function screenshot(?options:ScreenshotOptions):Promise<String>;
    public function setViewport(viewport:Viewport):Promise<String>;
}

interface Response {

}

typedef ScreenshotOptions = {
    var path:String;
}

typedef Viewport = {
    var width :Int;
    var height :Int;
}

typedef LaunchOptions = {
    var args:Array<String>;
}