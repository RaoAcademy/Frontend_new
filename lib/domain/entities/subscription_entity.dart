import 'package:rao_academy/domain/entities/active_plan_entity.dart';
import 'package:rao_academy/domain/entities/subcriptions.dart';

class SubscriptionEntity {
  SubscriptionEntity({
    this.gST,
    this.activePlans,
    this.pastPlans,
    this.couponAmount,
    this.internetHandling,
    this.subscriptions,
    this.userCoins,
  });

  SubscriptionEntity.fromJson(Map<String, dynamic> json) {
    gST = json['GST%'] as num?;
    if (json['activePlans'] != null) {
      activePlans = <ActivePlans>[];
      (json['activePlans'] as List).forEach((v) {
        activePlans!.add(ActivePlans.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['pastPlans'] != null) {
      pastPlans = <ActivePlans>[];
      (json['pastPlans'] as List).forEach((v) {
        pastPlans!.add(ActivePlans.fromJson(v as Map<String, dynamic>));
      });
    }
    couponAmount = json['couponAmount'] as num?;
    internetHandling = json['internetHandling'] as num?;
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      (json['subscriptions'] as List).forEach((v) {
        subscriptions!.add(Subscriptions.fromJson(v as Map<String, dynamic>));
      });
    }
    userCoins = json['userCoins'] as num?;
  }

  num? gST;
  List<ActivePlans>? activePlans;
  List<ActivePlans>? pastPlans;
  num? couponAmount;
  num? internetHandling;
  List<Subscriptions>? subscriptions;
  num? userCoins;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GST%'] = gST;
    if (activePlans != null) {
      data['activePlans'] = activePlans!.map((v) => v.toJson()).toList();
    }
    data['couponAmount'] = couponAmount;
    data['internetHandling'] = internetHandling;
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions!.map((v) => v.toJson()).toList();
    }
    data['userCoins'] = userCoins;
    return data;
  }
}
