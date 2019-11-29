import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10000] T;
int[10000] MAX_ST;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }
    auto CS = readln.split.to!(long[]);
    sort!"a > b"(CS);
    if (N == 1) {
        writeln(CS[0]);
        writeln(0);
        return;
    }
    long sum_c;
    foreach (c; CS[1..$]) sum_c += c;
    writeln(sum_c);

    int centroids;
    void find_centroids(int v, int parent) {
        MAX_ST[v] = 1;
        auto is_centroids = true;
        foreach (child; T[v]) {
            if (child == parent) continue;
            find_centroids(child, v);
            if (MAX_ST[child] > N / 2) is_centroids = false;
            MAX_ST[v] += MAX_ST[child];
        }
        if (N - MAX_ST[v] > N / 2) is_centroids = false;
        if (is_centroids) centroids = v;
    }
    find_centroids(0, -1);

    auto step = [centroids];
    MAX_ST[centroids] = -1;
    size_t i;
    long[] r;
    r.length = N;
    while (!step.empty) {
        int[] next_step;
        foreach (n; step) {
            r[n] = CS[i++];
            foreach (next; T[n]) {
                if (MAX_ST[next] < 0) continue;
                MAX_ST[next] = -1;
                next_step ~= next;
            }
        }
        step = next_step;
    }
    writeln(r.to!(string[]).join(" "));
}