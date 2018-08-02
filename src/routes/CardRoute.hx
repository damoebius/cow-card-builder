package routes;

import model.ModelLocator;
import express.Request;
import express.Response;
import express.Router;
import middleware.Cache;

class CardRoute extends BaseRoute {

    private static inline var PATH:String = "/langs/:langId/cards/:cardId";

    public function new() {
        super();
    }

    override public function init(router:Router):Void {

        router.get(PATH, function(req:Request, res:Response):Void {
            var langId = Std.parseInt(req.param("langId"));
            var cardId = Std.parseInt(req.param("cardId"));
            Cache.instance.reset();
            var card = ModelLocator.getInstance().langs[langId].cards[cardId];
            res.render('card', { card: card });

        });

    }
}
