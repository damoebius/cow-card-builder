package routes;

import express.Request;
import express.Response;
import express.Router;
import model.Card;
import model.ModelLocator;
import node.Puppeteer;

class RenderRoute extends BaseRoute {

    private static inline var PATH:String = "/render";

    private var _cards:Array<Card>;

    public function new() {
        super();
    }

    override public function init(router:Router):Void {

        router.get(PATH, function(req:Request, res:express.Response):Void {

            _cards = [];
            for (lang in ModelLocator.getInstance().langs) {
                for (card in lang.cards) {
                    _cards.push(card);
                }
            }
            res.write("Rendering all cards");
            Puppeteer.launch({args:["--no-sandbox","--disable-setuid-sandbox"]}).then(function(browser:Browser) {
                browser.newPage().then(function(page:Page) {
                    page.setViewport({width:816, height:1110}).then(function(result:String) {
                        render(res, page, _cards.pop());
                    });
                });
            });
        });

    }

    private function render(res:express.Response, page:Page, card:Card):Void {
        page.goto("http://localhost:4444/api/langs/"+card.langId+"/cards/"+card.id).then(function(response:node.Response) {
            page.screenshot({path:"www/build/"+card.langId + "_"+card.id+".png"}).then(function(result:String) {
                if (_cards.length > 0) {
                    res.write("\r card : "+card.langId + "_"+card.id +" rendered");
                    render(res, page, _cards.pop());
                } else {
                    res.end("\r done");
                }
            });
        });
    }

}
