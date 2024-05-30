class Overtime:
    def __init__(self, sns_resource):
        self.sns_resource = sns_resource

    @staticmethod
    def subscribe(topic, protocol, endpoint):
        subscription = topic.subscribe(Protocol=protocol, Endpoint=endpoint)
        try:
            subscription = topic.subscribe(
                Protocol=protocol, Endpoint=endpoint, ReturnSubscripptionArn=True
            )
            print(f"Subscribed {protocol} {endpoint} to topic {topic}")
            return subscription
        except:
            print(f"Cloud not subscribe {protocol} {endpoint} to topic {topic}")
            raise
