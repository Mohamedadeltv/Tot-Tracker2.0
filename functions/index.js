const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendPushNotification = functions.database
    .ref("IMU_LSM6DS3/1-setFloat/X")
    .onUpdate((change, context) => {
      const xValue = change.after.val();

      if (xValue === "1") {
        const payload = {
          notification: {
            title: "X Value Update",
            body: "The X value is now 1.",
          },
        };

        return admin.messaging().sendToTopic("your_topic_name", payload);
      }

      return null;
    });
