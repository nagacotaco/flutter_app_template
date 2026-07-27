/// アプリが使うバックエンド（BaaS）の切り替え。
///
/// IMPORTANT: コピー先アプリではどちらかに固定し、使わない方を削除する。
/// 削除手順は lib/features/auth/README.md を参照。
/// 切り替えると認証実装（core/auth/ の *_auth_repository.dart）と
/// main.dart の初期化が連動して切り替わる。
enum AppBackend { supabase, firebase }

/// このプロジェクトで使用するバックエンド。
const AppBackend appBackend = AppBackend.firebase;
