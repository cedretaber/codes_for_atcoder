import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "to", long, "c");

alias R = Tuple!(string, "s", long, "p");

Path[][2500] T;

enum REACH_GOAL = "reach_goal";
enum LOSS_CYCLE = "loss_cycle";
enum GAIN_CYCLE = "gain_cycle";
enum UNLIMITED = "unlimited";
enum USELESS = "useless";

void main()
{
    auto nmp = readln.split.to!(int[]);
    auto N = nmp[0];
    auto M = nmp[1];
    auto P = nmp[2].to!long;

    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        T[abc[0]-1] ~= Path(abc[1]-1, abc[2]);
    }
    T[N-1] ~= Path(N, P);

    R[2500] MEMO;
    R walk(int i, long p, long[int] h) {
        if (i == N) {
            return R(REACH_GOAL, p);
        }

        if (i in h) {
            return h[i] >= p ? R(LOSS_CYCLE, 0) : R(GAIN_CYCLE, 0);
        }
        if (MEMO[i].s == UNLIMITED || (MEMO[i].s == REACH_GOAL && MEMO[i].p >= p)) return R(USELESS, 0);
        h[i] = p;
        bool has_cycle;
        auto goal = R(USELESS, long.min);
        foreach (path; T[i]) {
            auto r = walk(path.to, p + path.c - P, h);
            if (r.s == LOSS_CYCLE || r.s == USELESS) continue;
            if (r.s == GAIN_CYCLE) has_cycle = true;
            if (r.s == UNLIMITED) {
                has_cycle = true;
                goal = r;
            }
            if (r.s == REACH_GOAL) {
                if (goal.s != UNLIMITED && r.p > goal.p) goal = r;
            }
        }
        h.remove(i);
        if (goal.s != USELESS) {
            MEMO[i] = has_cycle ? R(UNLIMITED, 0) : goal;
        } else {
            MEMO[i] = R(USELESS, 0);
        }
        return MEMO[i];
    }

    long[int] h;
    auto r = walk(0, 0, h);
    writeln(r.s == UNLIMITED ? -1 : max(0, r.p));
}