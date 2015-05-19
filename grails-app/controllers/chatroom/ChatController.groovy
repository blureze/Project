package chatroom

class ChatController {
	
    def index() { }

	def join(String nickname) {
		if ( !nickname || nickname.trim() == '' ) {
			redirect(action:'index')
			
		} else {
			session.nickname = nickname
			render (view: 'chat')
		}
	}
	
	def retrieveLatestMessages() {
		def messages = Message.listOrderByDate(order: 'desc', max:10)
		[messages:messages.reverse()]
	}
	
	def submitMessage(String message) {
		new Message(nickname: session.nickname, message:message).save()
		render "<script>retrieveLatestMessages()</script>"
	}	
	
	def signFlag(int flag) {
		//println "ori = " + flag

			/*def s = Sign.last()
			s.signFlag = flag
			s.save()			
			println "s = " + s.signFlag
			println "update: " + Sign.last().signFlag*/
			
			new Sign(signFlag:flag).save()
		render "<script>changeSign()</script>"		
	}
	
	def changeSign() {

		if(Sign.count() == 0) {
			def flag = 0
			new Sign(signFlag:flag).save()
			//println "count = " + Sign.count()
			[flag: flag]
		}
		else {
			
			def flag = Sign.last()
			//println "flag = " + flag.signFlag
			[flag: flag]
		}
		
		
	}
}
