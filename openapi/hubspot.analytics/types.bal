// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
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

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    # Represents API Key `hapikey`
    @display {label: "", kind: "password"}
    string hapikey;
|};

public type ErrorDetail record {
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
    # The name of the field or parameter in which the error was found.
    string 'in?;
    # The status code associated with the error detail
    string code?;
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # Context about the error condition
    record {} context?;
};

# Behavioural event payload
public type BehaviouralEvent record {
    # User token
    string utk?;
    # Email of visitor
    string email?;
    # Internal name of the event-type to trigger
    string eventName;
    # Map of properties for the event in the format property internal name - property value
    record {} properties;
    # The time when this event occurred (if any). If this isn't set, the current time will be used
    string occurredAt?;
    # The object id that this event occurred on. Could be a contact id or a visitor id.
    string objectId?;
};

public type Error record {
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
    # A unique identifier for the request. Include this value with any error reports or support tickets
    string correlationId;
    # The error category
    string category;
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # further information about the error
    ErrorDetail[] errors?;
    # Context about the error condition
    record {} context?;
    # A map of link names to associated URIs containing documentation about the error or recommended remediation steps
    record {} links?;
};
