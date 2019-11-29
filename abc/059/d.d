// 全てのパターンを計算する
// メモ化再帰
// Aliceｍの手番、Bobの手番が交互に来る。それぞれの手番で自分の勝ち筋が1つでもあればそれを採択
// なければ敗北
// 先頭で、Aliceに勝ち筋があればAliceの勝ち。なければBobの勝ち。

import std.stdio;

int[100][100] MEMO;

bool can_win(int x, int y)
{
    if (MEMO[x][y])
        return MEMO[x][y] == 1;

    
}