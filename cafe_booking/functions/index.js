const functions = require("firebase-functions");
const admin = require("firebase-admin");
const auth = require("firebase-auth");

var serviceAccount = require("./cafebooking-9a2cd-firebase-adminsdk-emefe-8badcacf7a.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

async function updateOrCreateUser(updateParams) {

	try {
		var userRecord = await admin.auth().getUserByEmail(updateParams['email']);
	} catch (error) {
		if (error.code === 'auth/user-not-found') {
			return admin.auth().createUser(updateParams);
		}
		throw error;
	}
	return userRecord;
}
//! Firebase 특성상 email 필드는 필수이다.
//! 사업자등록 이후 email을 필수옵션으로 설정할 수 있으니 (카카오 개발자 사이트) 꼭 설정하자.
//! 테스트 단계에서는 email을 동의하지 않고 로그인 할 경우 에러가 발생한다.

exports.createCustomToken = functions.https.onRequest(async (request, response) => {
  const user = request.body;

  const uid = `${user.uid}`;
  const updateParams = {
    uid: uid,
    email: user.email,
    provider:user.provider,
  };

  try {
    await admin.auth().updateUser(uid, updateParams);
  } catch (e) {
    updateParams["uid"] = uid;
    await admin.auth().createUser(updateParams);
  }

  const token = await admin.auth().createCustomToken(uid,{provider:user.provider});

  response.send(token);
});