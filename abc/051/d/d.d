import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

bool[100] USED_NODE;
bool[1000] USED_PATH;
Tuple!(int, "idx", long, "len")[1000][1000] PATH;

alias Next = Tuple!(int, "node", int[], "paths", long, "len");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto n = nm[0];
    auto m = nm[1];

    foreach (i; 0..m) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0] - 1;
        auto b = abc[1] - 1;
        auto c = abc[2];
        PATH[a][b].idx = i;
        PATH[a][b].len = c;
        PATH[b][a].idx = i;
        PATH[b][a].len = c;
    }

    foreach (x; 0..n) {
        auto p = x;
        USED_NODE = false;
        int node_cnt;
        int[] before_paths;
        Next[] nexts;
        long len;
        for (;;) {
            if (!USED_NODE[p] && ++node_cnt == n) {
                foreach (path; before_paths)
                    USED_PATH[path] = true;
                break;
            }

            auto min = long.max;
            int next = -1;
            int use_path = -1;
            int[] next_bofore_path;

            foreach (path; nexts) {
                if (path.len < min) {
                    min = path.len;
                    next = path.node;
                    next_bofore_path = path.paths;
                }
            }

            if (!USED_NODE[p]) {
                foreach (int i, path; PATH[p]) {
                    if (!path.len) continue;
                    auto t_len = path.len + len;
                    nexts ~= Next(i, before_paths ~ path.idx, t_len);
                    if (t_len < min) {
                        min = t_len;
                        next = i;
                        next_bofore_path = before_paths ~ path.idx;
                    }
                }

                USED_NODE[p] = true;
            }

            foreach (i, path; nexts)
                if (path.len == min) {
                    nexts = nexts[0..i] ~ (nexts.length == i + 1 ? [] : nexts[0..i] ~ nexts[i+1..$]);
                    break;
                }

            len = min;
            p = next;
            before_paths = next_bofore_path;
        }
    }

    writeln(USED_PATH[0..m].count!"!a");
}