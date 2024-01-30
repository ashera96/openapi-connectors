// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/constraint;
import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# Specifies a tool the model should use. Use to force the model to call a specific function.
public type ChatCompletionNamedToolChoice record {
    # The type of the tool. Currently, only `function` is supported.
    "function" 'type;
    # The function that should be called.
    ChatCompletionNamedToolChoice_function 'function;
};

# Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
# 
# # Deprecated
@deprecated
public type ChatCompletionRequestAssistantMessage_function_call record {
    # The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function.
    string arguments;
    # The name of the function to call.
    string name;
};

public type ChatCompletionTokenLogprob record {
    # The token.
    string token;
    # The log probability of this token.
    decimal logprob;
    # A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
    int[]? bytes;
    # List of the most likely tokens and their log probability, at this token position. In rare cases, there may be fewer than the number of requested `top_logprobs` returned.
    ChatCompletionTokenLogprob_top_logprobs[] top_logprobs;
};

public type CreateChatCompletionResponse_choices record {
    # The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence,
    # `length` if the maximum number of tokens specified in the request was reached,
    # `content_filter` if content was omitted due to a flag from our content filters,
    # `tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.
    "stop"|"length"|"tool_calls"|"content_filter"|"function_call" finish_reason;
    # The index of the choice in the list of choices.
    int index;
    # A chat completion message generated by the model.
    ChatCompletionResponseMessage message;
    # Log probability information for the choice.
    CreateChatCompletionResponse_logprobs? logprobs?;
};

public type ChatCompletionRequestMessage ChatCompletionRequestSystemMessage|ChatCompletionRequestUserMessage|ChatCompletionRequestAssistantMessage|ChatCompletionRequestToolMessage|ChatCompletionRequestFunctionMessage;

public type FunctionObject record {
    # A description of what the function does, used by the model to choose when and how to call the function.
    string description?;
    # The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
    string name;
    # The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/text-generation/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format. 
    # 
    # Omitting `parameters` defines a function with an empty parameter list.
    FunctionParameters parameters?;
};

public type ChatCompletionRequestMessageContentPart ChatCompletionRequestMessageContentPartText|ChatCompletionRequestMessageContentPartImage;

# The function that the model called.
public type ChatCompletionMessageToolCall_function record {
    # The name of the function to call.
    string name;
    # The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function.
    string arguments;
};

public type CreateChatCompletionRequest record {
    # A list of messages comprising the conversation so far. [Example Python code](https://cookbook.openai.com/examples/how_to_format_inputs_to_chatgpt_models).
    @constraint:Array {minLength: 1}
    ChatCompletionRequestMessage[] messages;
    # ID of the model to use. See the [model endpoint compatibility](/docs/models/model-endpoint-compatibility) table for details on which models work with the Chat API.
    string|"gpt-4-0125-preview"|"gpt-4-turbo-preview"|"gpt-4-1106-preview"|"gpt-4-vision-preview"|"gpt-4"|"gpt-4-0314"|"gpt-4-0613"|"gpt-4-32k"|"gpt-4-32k-0314"|"gpt-4-32k-0613"|"gpt-3.5-turbo"|"gpt-3.5-turbo-16k"|"gpt-3.5-turbo-0301"|"gpt-3.5-turbo-0613"|"gpt-3.5-turbo-1106"|"gpt-3.5-turbo-16k-0613" model;
    # Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    # 
    # [See more information about frequency and presence penalties.](/docs/guides/text-generation/parameter-details)
    decimal? frequency_penalty = 0;
    # Modify the likelihood of specified tokens appearing in the completion.
    # 
    # Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer) to an associated bias value from -100 to 100. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
    record {|int...;|}? logit_bias?;
    # Whether to return log probabilities of the output tokens or not. If true, returns the log probabilities of each output token returned in the `content` of `message`. This option is currently not available on the `gpt-4-vision-preview` model.
    boolean? logprobs?;
    # An integer between 0 and 5 specifying the number of most likely tokens to return at each token position, each with an associated log probability. `logprobs` must be set to `true` if this parameter is used.
    int? top_logprobs?;
    # The maximum number of [tokens](/tokenizer) that can be generated in the chat completion.
    # 
    # The total length of input tokens and generated tokens is limited by the model's context length. [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken) for counting tokens.
    int? max_tokens?;
    # How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs.
    int? n = 1;
    # Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    # 
    # [See more information about frequency and presence penalties.](/docs/guides/text-generation/parameter-details)
    decimal? presence_penalty = 0;
    # An object specifying the format that the model must output. Compatible with [GPT-4 Turbo](/docs/models/gpt-4-and-gpt-4-turbo) and `gpt-3.5-turbo-1106`.
    # 
    # Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
    # 
    # **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
    CreateChatCompletionRequest_response_format response_format?;
    # This feature is in Beta.
    # If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same `seed` and parameters should return the same result.
    # Determinism is not guaranteed, and you should refer to the `system_fingerprint` response parameter to monitor changes in the backend.
    int? seed?;
    # Up to 4 sequences where the API will stop generating further tokens.
    string|string[]? stop = "null";
    # If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format) as they become available, with the stream terminated by a `data: [DONE]` message. [Example Python code](https://cookbook.openai.com/examples/how_to_stream_completions).
    boolean? 'stream = false;
    # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    # 
    # We generally recommend altering this or `top_p` but not both.
    decimal? temperature = 1;
    # An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    # 
    # We generally recommend altering this or `temperature` but not both.
    decimal? top_p = 1;
    # A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for.
    ChatCompletionTool[] tools?;
    # Controls which (if any) function is called by the model.
    # `none` means the model will not call a function and instead generates a message.
    # `auto` means the model can pick between generating a message or calling a function.
    # Specifying a particular function via `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that function.
    # 
    # `none` is the default when no functions are present. `auto` is the default if functions are present.
    ChatCompletionToolChoiceOption tool_choice?;
    # A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices/end-user-ids).
    string user?;
    # Deprecated in favor of `tool_choice`.
    # 
    # Controls which (if any) function is called by the model.
    # `none` means the model will not call a function and instead generates a message.
    # `auto` means the model can pick between generating a message or calling a function.
    # Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
    # 
    # `none` is the default when no functions are present. `auto` is the default if functions are present.
    "none"|"auto"|ChatCompletionFunctionCallOption function_call?;
    # Deprecated in favor of `tools`.
    # 
    # A list of functions the model may generate JSON inputs for.
    @constraint:Array {maxLength: 128, minLength: 1}
    ChatCompletionFunctions[] functions?;
};

# Log probability information for the choice.
public type CreateChatCompletionResponse_logprobs record {
    # A list of message content tokens with log probability information.
    ChatCompletionTokenLogprob[]? content;
};

public type ChatCompletionRequestAssistantMessage record {
    # The contents of the assistant message. Required unless `tool_calls` or `function_call` is specified.
    string? content?;
    # The role of the messages author, in this case `assistant`.
    "assistant" role;
    # An optional name for the participant. Provides the model information to differentiate between participants of the same role.
    string name?;
    # The tool calls generated by the model, such as function calls.
    ChatCompletionMessageToolCalls tool_calls?;
    # Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    ChatCompletionRequestAssistantMessage_function_call function_call?;
};

# Controls which (if any) function is called by the model.
# `none` means the model will not call a function and instead generates a message.
# `auto` means the model can pick between generating a message or calling a function.
# Specifying a particular function via `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that function.
# 
# `none` is the default when no functions are present. `auto` is the default if functions are present.
public type ChatCompletionToolChoiceOption "none"|"auto"|ChatCompletionNamedToolChoice;

# Usage statistics for the completion request.
public type CompletionUsage record {
    # Number of tokens in the generated completion.
    int completion_tokens;
    # Number of tokens in the prompt.
    int prompt_tokens;
    # Total number of tokens used in the request (prompt + completion).
    int total_tokens;
};

# The function that should be called.
public type ChatCompletionNamedToolChoice_function record {
    # The name of the function to call.
    string name;
};

public type ChatCompletionRequestUserMessage record {
    # The contents of the user message.
    string|ChatCompletionRequestMessageContentPart[] content;
    # The role of the messages author, in this case `user`.
    "user" role;
    # An optional name for the participant. Provides the model information to differentiate between participants of the same role.
    string name?;
};

# The tool calls generated by the model, such as function calls.
public type ChatCompletionMessageToolCalls ChatCompletionMessageToolCall[];

# Represents a chat completion response returned by model, based on the provided input.
public type CreateChatCompletionResponse record {
    # A unique identifier for the chat completion.
    string id;
    # A list of chat completion choices. Can be more than one if `n` is greater than 1.
    CreateChatCompletionResponse_choices[] choices;
    # The Unix timestamp (in seconds) of when the chat completion was created.
    int created;
    # The model used for the chat completion.
    string model;
    # This fingerprint represents the backend configuration that the model runs with.
    # 
    # Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism.
    string system_fingerprint?;
    # The object type, which is always `chat.completion`.
    "chat.completion" 'object;
    # Usage statistics for the completion request.
    CompletionUsage usage?;
};

@deprecated
public type ChatCompletionRequestFunctionMessage record {
    # The role of the messages author, in this case `function`.
    "function" role;
    # The contents of the function message.
    string? content;
    # The name of the function to call.
    string name;
};

# Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
public type ChatCompletionFunctionCallOption record {
    # The name of the function to call.
    string name;
};

public type ChatCompletionRequestToolMessage record {
    # The role of the messages author, in this case `tool`.
    "tool" role;
    # The contents of the tool message.
    string content;
    # Tool call that this message is responding to.
    string tool_call_id;
};

@deprecated
public type ChatCompletionFunctions record {
    # A description of what the function does, used by the model to choose when and how to call the function.
    string description?;
    # The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
    string name;
    # The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/text-generation/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format. 
    # 
    # Omitting `parameters` defines a function with an empty parameter list.
    FunctionParameters parameters?;
};

public type ChatCompletionTool record {
    # The type of the tool. Currently, only `function` is supported.
    "function" 'type;
    FunctionObject 'function;
};

public type ChatCompletionRequestSystemMessage record {
    # The contents of the system message.
    string content;
    # The role of the messages author, in this case `system`.
    "system" role;
    # An optional name for the participant. Provides the model information to differentiate between participants of the same role.
    string name?;
};

public type ChatCompletionMessageToolCall record {
    # The ID of the tool call.
    string id;
    # The type of the tool. Currently, only `function` is supported.
    "function" 'type;
    # The function that the model called.
    ChatCompletionMessageToolCall_function 'function;
};

public type ChatCompletionRequestMessageContentPartImage_image_url record {
    # Either a URL of the image or the base64 encoded image data.
    string url;
    # Specifies the detail level of the image. Learn more in the [Vision guide](/docs/guides/vision/low-or-high-fidelity-image-understanding).
    "auto"|"low"|"high" detail = "auto";
};

# An object specifying the format that the model must output. Compatible with [GPT-4 Turbo](/docs/models/gpt-4-and-gpt-4-turbo) and `gpt-3.5-turbo-1106`.
# 
# Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
# 
# **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
public type CreateChatCompletionRequest_response_format record {
    # Must be one of `text` or `json_object`.
    "text"|"json_object" 'type?;
};

# A chat completion message generated by the model.
public type ChatCompletionResponseMessage record {
    # The contents of the message.
    string? content;
    # The tool calls generated by the model, such as function calls.
    ChatCompletionMessageToolCalls tool_calls?;
    # The role of the author of this message.
    "assistant" role;
    # Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    ChatCompletionRequestAssistantMessage_function_call function_call?;
};

public type ChatCompletionTokenLogprob_top_logprobs record {
    # The token.
    string token;
    # The log probability of this token.
    decimal logprob;
    # A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
    int[]? bytes;
};

# The role of the author of a message
public type ChatCompletionRole "system"|"user"|"assistant"|"tool"|"function";

public type ChatCompletionRequestMessageContentPartImage record {
    # The type of the content part.
    "image_url" 'type;
    ChatCompletionRequestMessageContentPartImage_image_url image_url;
};

public type ChatCompletionRequestMessageContentPartText record {
    # The type of the content part.
    "text" 'type;
    # The text content.
    string text;
};

# The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/text-generation/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format. 
# 
# Omitting `parameters` defines a function with an empty parameter list.
public type FunctionParameters record {
};
