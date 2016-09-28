

// abstype chanx
// 
// extern fun chanx_create {a:t@ype} (n: int): chanx
// extern fun chanx_read (ch: chanx): @(chanx, int)
// 
// val ch = chanx_create {@(chanx, int)} (3): chanx
// 
// 
// abstype chan(a:t@ype)
// 
// typedef chanr = chan (@(x, int))
// 
// 
// extern fun chanx_read {a:t@ype} (ch: chan a): a
// 
// typedef chanb (b:t@ype) = chan(b)
// 
// typedef chanx (x:t@ype) = chan (chanb (x))
// 
// typedef a = (int, b)
// and b = int



////


typedef chana = chan (chana)

