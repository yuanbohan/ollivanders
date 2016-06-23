# Commands:
#   hubot photo xxx - show you some photo you may interest

module.exports = (robot) ->

  robot.respond /photo (.+)/i, (res) ->
    q = res.match[1]
    key = YOUR_KEY
    url = "https://pixabay.com/api/?key=#{key}&q=#{q}&image_type=photo"
    robot.http(url)
         .get() (err, resp, body) ->
           if err
             res.reply "Sorry, ERROR somewhere -_-"
             return

           {totalHits, hits} = JSON.parse body
           if totalHits? and totalHits > 0 and hits? and hits.length > 0
             one = hits[Math.floor(Math.random() * hits.length)]
             tags = one.tags
             webformatURL = one.webformatURL
             attachments = [{images: [{url: webformatURL}]}]
             res.send tags, attachments
           else
             res.reply "sorry, empty result -_-"