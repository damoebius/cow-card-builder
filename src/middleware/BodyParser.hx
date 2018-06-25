package middleware;

import express.Middleware;
@:jsRequire("body-parser")
extern class BodyParser {
    public static function json():Middleware;
}
