enum FactionType { hacker, enforcer, ghost }

extension FactionTypeX on FactionType {
  String get id {
    switch (this) {
      case FactionType.hacker:
        return 'hacker';
      case FactionType.enforcer:
        return 'enforcer';
      case FactionType.ghost:
        return 'ghost';
    }
  }

  String get label {
    switch (this) {
      case FactionType.hacker:
        return 'Hacker';
      case FactionType.enforcer:
        return 'Enforcer';
      case FactionType.ghost:
        return 'Ghost';
    }
  }
}
